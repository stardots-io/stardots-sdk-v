module main

import stardots

fn main() {
	// Initialize the client
	client_key := 'Your client key'
	client_secret := 'Your client secret'
	client := stardots.new(client_key, client_secret, '')

	// Get space list
	println('Getting space list...')
	space_list_params := stardots.SpaceListReq{
		page: 1
		page_size: 20
	}
	
	space_list := client.get_space_list(space_list_params) or {
		println('Error getting space list: ${err}')
		return
	}
	println('Space list: ${space_list}')

	// Create a new space
	println('\nCreating space...')
	create_params := stardots.CreateSpaceReq{
		space: 'my-space'
		public: true
	}
	
	create_result := client.create_space(create_params) or {
		println('Error creating space: ${err}')
		return
	}
	println('Create space result: ${create_result}')

	// Upload a file
	println('\nUploading file...')
	filename := 'example.txt'
	file_content := 'Hello, StarDots!'.bytes()
	
	upload_params := stardots.UploadFileReq{
		filename: filename
		space: 'my-space'
		file_content: file_content
	}
	
	upload_result := client.upload_file(upload_params) or {
		println('Error uploading file: ${err}')
		return
	}
	println('Upload result: ${upload_result}')

	// Get space file list
	println('\nGetting space file list...')
	file_list_params := stardots.SpaceFileListReq{
		page: 1
		page_size: 20
		space: 'my-space'
	}
	
	file_list := client.get_space_file_list(file_list_params) or {
		println('Error getting file list: ${err}')
		return
	}
	println('File list: ${file_list}')

	// Get file access ticket
	println('\nGetting file access ticket...')
	ticket_params := stardots.FileAccessTicketReq{
		filename: filename
		space: 'my-space'
	}
	
	ticket_result := client.file_access_ticket(ticket_params) or {
		println('Error getting access ticket: ${err}')
		return
	}
	println('Access ticket: ${ticket_result}')

	// Toggle space accessibility
	println('\nToggling space accessibility...')
	toggle_params := stardots.ToggleSpaceAccessibilityReq{
		space: 'my-space'
		public: false
	}
	
	toggle_result := client.toggle_space_accessibility(toggle_params) or {
		println('Error toggling accessibility: ${err}')
		return
	}
	println('Toggle result: ${toggle_result}')

	// Delete file
	println('\nDeleting file...')
	delete_file_params := stardots.DeleteFileReq{
		filename_list: [filename]
		space: 'my-space'
	}
	
	delete_file_result := client.delete_file(delete_file_params) or {
		println('Error deleting file: ${err}')
		return
	}
	println('Delete file result: ${delete_file_result}')

	// Delete space
	println('\nDeleting space...')
	delete_space_params := stardots.DeleteSpaceReq{
		space: 'my-space'
	}
	
	delete_space_result := client.delete_space(delete_space_params) or {
		println('Error deleting space: ${err}')
		return
	}
	println('Delete space result: ${delete_space_result}')
} 