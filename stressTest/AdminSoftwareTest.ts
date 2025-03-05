import { faker } from '@faker-js/faker'
import * as ep from './client/clientAdminSoft.ts'

export async function AdminSoftwareTest() {


    const loginData = {
        id: 1,
        passwordHash: '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918'
    }

    const _resLogin = await ep.login(loginData)

    for(let i = 0; i<=30; i++){
        const createUserData = {
            idType: faker.helpers.arrayElement([0, 1]),
            id: faker.number.int({max: 999999, min: 99999999}),
            name: faker.person.firstName(),
            lastname: faker.person.lastName(),
            password: faker.animal.cetacean(),
            userType: faker.helpers.arrayElement([0, 1, 2, 3])
        }
        const resCreateUser = await ep.createUser(createUserData)
        console.log(resCreateUser)

        const resGetAllUsers = await ep.getAllUsers()
        console.log(resGetAllUsers)

        for(let i = 0; i<= 15; i++){
            const resDeleteUser = await ep.deleteUser(resGetAllUsers.data[faker.number.int({max: 10, min: 1})])
            console.log(resDeleteUser)
        }

        const resGetDeactivatedUsers = await ep.getDeactivatedUsers()
        console.log(resGetDeactivatedUsers)

        for(let i = 0; i <= 5; i++){
            const resReactivateUser = await ep.reactivateUser(resGetDeactivatedUsers[faker.number.int({max: 10, min: 1})])
            console.log(resReactivateUser)
        }

        for(let i = 0; i <= 5; i++){
            const data = {
                userId: resGetAllUsers.data[faker.number.int({max: 10, min: 1})],
                newPassword: faker.animal.crocodilia()
            }
            const resChangePassword = await ep.changePassword(data)
            console.log(resChangePassword)
        }

        for(let i = 0; i <= 5; i++){
            const data = {
                userId: resGetAllUsers.data[faker.number.int({max: 10, min: 1})],
                newUserType: faker.helpers.arrayElement([0, 1, 2, 3])
            }
            const resChangeUserType = await ep.changeUserType(data)
            console.log(resChangeUserType)
        }
    }
}