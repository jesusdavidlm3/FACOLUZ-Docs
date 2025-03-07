import { faker } from '@faker-js/faker'
import * as ep from './client/clientAdminSoft.ts'

export async function AdminSoftwareTest() {
while(true){
    // Iniciamos sesion
    const loginData = {
        id: 1,
        passwordHash: '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918'
    }
    const _resLogin = await ep.login(loginData)

    // Creamos 30 usuarios
    for(let i = 0; i<=30; i++){
        const createUserData = {
            idType: faker.helpers.arrayElement([0, 1]),
            id: faker.number.int({min: 999999, max: 99999999}),
            name: faker.person.firstName(),
            lastname: faker.person.lastName(),
            password: faker.animal.cetacean(),
            userType: faker.helpers.arrayElement([0, 1, 2, 3])
        }
        const resCreateUser = await ep.createUser(createUserData)
        console.log(resCreateUser.status)
    }

    // Obtenemos a todos los usuarios activos
    const resGetAllUsers = await ep.getAllUsers()
    console.log(resGetAllUsers.data, resGetAllUsers.status)

    // Cambiamos la contraseña a 5 usuarios
    for(let i = 0; i <= 5; i++){
        let id = resGetAllUsers.data[faker.number.int({max: 10, min: 1})]
        while(id == undefined){
            id = resGetAllUsers.data[faker.number.int({max: 10, min: 1})]
        }
        const data = {
            userId: id.id,
            newPassword: faker.animal.crocodilia()
        }
        const resChangePassword = await ep.changePassword(data)
        console.log(resChangePassword.status)
    }

    // Cambiamos el tipo de usuario a 5 usuarios
    for(let i = 0; i <= 5; i++){
        let id = resGetAllUsers.data[faker.number.int({max: 10, min: 1})]
        while(id == undefined){
            id = resGetAllUsers.data[faker.number.int({max: 10, min: 1})]
        }
        const data = {
            userId: id.id,
            newType: faker.helpers.arrayElement([0, 1, 2, 3])
        }
        const resChangeUserType = await ep.changeUserType(data)
        console.log(resChangeUserType.status)
    }

    // Desactivamos 15 usuarios
    for(let i = 0; i<= 15; i++){
        let id = resGetAllUsers.data[faker.number.int({max: 10, min: 1})]
        while(id == undefined){
            id = resGetAllUsers.data[faker.number.int({max: 10, min: 1})]
        }
        const resDeleteUser = await ep.deleteUser(id.id)
        console.log(resDeleteUser.status)
    }

    // Obtenemos la lista de usuarios desactivados
    const resGetDeactivatedUsers = await ep.getDeactivatedUsers()
    console.log(resGetDeactivatedUsers.data, resGetDeactivatedUsers.status)

    // Reactivamos 5 usuarios
    // for(let i = 0; i <= 5; i++){
    //     let id = resGetDeactivatedUsers[faker.number.int({max: 10, min: 1})]
    //     while(id == undefined){
    //         id = resGetDeactivatedUsers[faker.number.int({max: 10, min: 1})]
    //     }
    //     const resReactivateUser = await ep.reactivateUser(id.id)
    //     console.log(resReactivateUser.status)
    // }
}
}