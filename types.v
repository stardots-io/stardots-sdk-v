module stardots

import json

// CommonResponse Common HTTP response body
// All interface responses maintain a unified data structure
pub struct CommonResponse {
pub:
	code      int    [json: 'code']      // Service response code.
	message   string [json: 'message']   // Message prompt of the operation result.
	request_id string [json: 'requestId'] // A unique number for the request, which can be used for troubleshooting.
	success   bool   [json: 'bool']      // Indicates whether the business operation is successful.
	timestamp i64    [json: 'ts']        // Server millisecond timestamp.
	data      json.Any [json: 'data']    // Business data field. This field can be of any data type. For specific data types, please refer to the corresponding interface.
}

// PaginationReq Paginator request parameters
pub struct PaginationReq {
pub:
	page     int [json: 'page']     // Page number, default value is 1.
	page_size int [json: 'pageSize'] // The number of entries per page ranges from 1 to 100, and the default value is 20.
}

// PaginationResp Paginator response data structure
pub struct PaginationResp {
pub:
	page        int  [json: 'page']        // Page number, default value is 1.
	page_size   int  [json: 'pageSize']    // The number of entries per page ranges from 1 to 100, and the default value is 20.
	total_count i64  [json: 'totalCount']  // The total number of entries.
}

// SpaceListReq Get space list request parameters
pub struct SpaceListReq {
pub:
	PaginationReq
}

// SpaceInfo Space information data structure
pub struct SpaceInfo {
pub:
	name       string [json: 'name']       // The name of the space.
	public     bool   [json: 'public']     // Whether the accessibility of the space is false.
	created_at i64    [json: 'createdAt']  // The system timestamp in seconds when the space was created. The time zone is UTC+8.
	file_count i64    [json: 'fileCount']  // The number of files in this space.
}

// SpaceListResp Get space list response data structure
pub struct SpaceListResp {
pub:
	CommonResponse
	data []SpaceInfo [json: 'data']
}

// CreateSpaceReq Create space request parameters
pub struct CreateSpaceReq {
pub:
	space  string [json: 'space']  // The name of the space. It can only be a combination of letters or numbers, and the length is 4 to 15 characters.
	public bool   [json: 'public'] // Specifies whether the space is publicly accessible. The default value is false.
}

// CreateSpaceResp Create space response data structure
pub struct CreateSpaceResp {
pub:
	CommonResponse
}

// DeleteSpaceReq Delete space request parameters
pub struct DeleteSpaceReq {
pub:
	space string [json: 'space'] // The name of the space. It can only be a combination of letters or numbers, and the length is 4 to 15 characters.
}

// DeleteSpaceResp Delete space response data structure
pub struct DeleteSpaceResp {
pub:
	CommonResponse
}

// ToggleSpaceAccessibilityReq ToggleSpaceAccessibility space request parameters
pub struct ToggleSpaceAccessibilityReq {
pub:
	space  string [json: 'space']  // The name of the space. It can only be a combination of letters or numbers, and the length is 4 to 15 characters.
	public bool   [json: 'public'] // Specifies whether the space is publicly accessible. The default value is false.
}

// ToggleSpaceAccessibilityResp ToggleSpaceAccessibility space response data structure
pub struct ToggleSpaceAccessibilityResp {
pub:
	CommonResponse
}

// SpaceFileListReq Get space file list request parameters
pub struct SpaceFileListReq {
pub:
	PaginationReq
	space string [json: 'space'] // The name of the space. It can only be a combination of letters or numbers, and the length is 4 to 15 characters.
}

// FileInfo File information data structure
pub struct FileInfo {
pub:
	name        string [json: 'name']        // The name of the file.
	byte_size   i64    [json: 'byteSize']    // The size of the file in bytes.
	size        string [json: 'size']        // File size, formatted for readability.
	uploaded_at i64    [json: 'uploadedAt']  // The timestamp of the file upload in seconds. The time zone is UTC+8.
	url         string [json: 'url']         // The access address of the file. Note that if the accessibility of the space is private, this field value will carry the access ticket, which is valid for 20 seconds.
}

// SpaceFileListResp Get space file list response data structure
pub struct SpaceFileListResp {
pub:
	CommonResponse
	data struct {
		list []FileInfo [json: 'list']
	} [json: 'data']
}

// FileAccessTicketReq Get file access ticket request parameters
pub struct FileAccessTicketReq {
pub:
	filename string [json: 'filename'] // The name of the file.
	space    string [json: 'space']    // The name of the space. It can only be a combination of letters or numbers, and the length is 4 to 15 characters.
}

// FileAccessTicketResp Get file access ticket response data structure
pub struct FileAccessTicketResp {
pub:
	CommonResponse
	data struct {
		ticket string [json: 'ticket']
	} [json: 'data']
}

// UploadFileReq Upload file request parameters
pub struct UploadFileReq {
pub:
	filename     string [json: 'filename']     // The name of the file.
	space        string [json: 'space']        // The name of the space. It can only be a combination of letters or numbers, and the length is 4 to 15 characters.
	file_content []u8   [json: 'fileContent'] // The file bytes content
}

// UploadFileResp Upload file response data structure
pub struct UploadFileResp {
pub:
	CommonResponse
	data struct {
		space    string [json: 'space']    // The name of the space. It can only be a combination of letters or numbers, and the length is 4 to 15 characters.
		filename string [json: 'filename'] // The name of the file.
		url      string [json: 'url']      // The access address of the file. Note that if the accessibility of the space is private, this field value will carry the access ticket, which is valid for 20 seconds.
	} [json: 'data']
}

// DeleteFileReq Delete file request parameters
pub struct DeleteFileReq {
pub:
	filename_list []string [json: 'filenameList'] // The name of the space. It can only be a combination of letters or numbers, and the length is 4 to 15 characters.
	space         string   [json: 'space']        // The name of the space. It can only be a combination of letters or numbers, and the length is 4 to 15 characters.
}

// DeleteFileResp Delete file response data structure
pub struct DeleteFileResp {
pub:
	CommonResponse
} 