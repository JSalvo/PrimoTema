require 'rmagick'

class Image < ActiveRecord::Base
	has_many :articles_images
	has_many :articles, through: :articles_images

	# Produce il percorso per visualizzare un copia ridimensionata di questa
	# immagine. Se non esiste l'immagine delle dimensioni indicate, viene creata.
	# NOTA: l'immagine viene creata solo se già non esiste, a meno che il flag force, non
	# sia impostato a true
	def get_image_auto_cropped_and_resized_path(width, height, force=false)

		if self.name.nil?
			return nil
		end

		# Percorso assoluto dell'immagine
		image_url = Rails.root.join("public", "images", "articles_images", "#{self.id}", self.name).to_s

		# Percorso relativo della directory da creare che conterrà l'immagine
		# desiderata
		directory_to_create_path = "articles_images/#{self.id}/cer/#{width}x#{height}" #cer (cropped and resized)

		# Percorso assoluto della directory da creare che conterrà l'immagine
		# desiderata
		directory_to_create_url =
			Rails.root.join(
				"public", "images", directory_to_create_path).to_s

		# Se la directory non esiste, la creo ...
		if not File.exists?(directory_to_create_url)
			Dir.mkdir Rails.root.join(directory_to_create_url)
		end

		# Percorso assoluto del file da creare
		file_to_create_url =
			Rails.root.join(
				"public", "images", directory_to_create_path, self.name).to_s

		# Se il file non esiste, lo creo (se force è true, lo ricreo)
		if not File.exists?(file_to_create_url) || force

			# Carico l'immagine principale
			img_file = Magick::Image::read(image_url).first

			mul = width.to_f / img_file.columns
			new_height = img_file.rows*mul
			cropped_and_resized_img_file = nil

			if (new_height > height) # Scalo in proprozione alla nuova larghezza
				resized_img_file = img.scale(width, new_height.to_i)

				# ritaglio l'immagine sopra e sotto
				cropped_and_resized_img_file = resized_img_file.crop(0, ((new_height - height)/2.0).to_i, width, height)
			else # Scalo in proporzione alla nuova altezza
				mul = height.to_f / img_file.rows
				new_width = img_file.columns*mul

				resized_img_file = img_file.scale(new_width.to_i, height)

				# ritaglio l'immagine a destra e sinistra
				cropped_and_resized_img_file = resized_img_file.crop(((new_width - width)/2.0).to_i, 0, width, height)
			end

			# Scrivo l'immagine su server
			cropped_and_resized_img_file.write file_to_create_url
		end

		# Produco il percorso relativo da inserire nella pagina web per visualizzare
		# l'immagine ridimensionata
		"#{directory_to_create_path}/#{self.name}"
	end

	def get_150x150(force = false)
		get_image_auto_cropped_and_resized_path(150, 150, force)
	end

	def get_300x300(force = false)
		get_image_auto_cropped_and_resized_path(300, 300, force)
	end

	def get_768x512(force = false)
		get_image_auto_cropped_and_resized_path(768, 512, force)
	end

end
