import { httpMethods } from './httpMethods'

const http = new httpMethods()
let token: string

export async function login(data){
	const res = await http.post('api/login', null, data)
	if(res.status == 200){
		token = res.data.jwt
	}
	return res
}

export async function createUser(data) {
	const res = await http.post('api/createUser', token, data)
	return res
}

export async function deleteUser(userId) {
	const res = await http.delete(`api/deleteUser/${userId}`, token)
	return res
}

export async function reactivateUser(data) {
	const res = await http.patch('api/reactivateUser')
}

export async function assignTeacher(data) {
	const res = await http.post('api/assignTeacher', token, data)
	return res
}

export async function asignIntoAsignature(data) {
	const res = await http.post('api/asignIntoAsignature', token, data)
	return res
}

export async function getSectionInfo(section) {
	const res = await http.get(`api/getSectioninfo/${section}`,token)
	return res
}

export async function getAsignatureList(section, asignature) {
	const res = await http.get(`api/getAsignatureList/${section}/${asignature}`, token)
	return res
}

export async function clearAllAsignatures() {
	const res = await http.delete('api/clearAllAsignatures', token, null)
	return res
}

export async function clearAsignature(asignature) {
	const res = await http.delete(`api/clearAsignature/${asignature}`, token)
	return res
}

export async function getInfoByIdentification(identification){
	const res = await http.get(`api/getInfoByIdentification/${identification}`, token)
	return res
}

export async function aviableStudentsList(searchParam) {
	const res = await http.get(`api/aviableStudentsList/${searchParam}`, token)
	return res
}

export async function aviableTeachersList() {
	const res = await http.get("api/aviableTeachersList", token)
	return res
}

export async function removeFromAsignature(identification){
	const res = await http.delete(`api/removeFromAsignature`, token, identification)
	return res
}

export async function asignTeacher(data){
	const res = await http.put("api/asignTeacher", token, data)
	return res
}