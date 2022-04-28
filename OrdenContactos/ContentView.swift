//
//  ContentView.swift
//  OrdenContactos
//
//  Created by Eduardo Herrera Barros on 22-04-22.
//

import SwiftUI
import Contacts

struct ContentView: View {
    
    var body: some View {
        Text("Hola")
            .padding()
            .onAppear {
                Task.init{
                await traerTodosContactos()
                }
            }
    }
    


func traerTodosContactos() async {
    let store = CNContactStore()
    
    let keys = [CNContactGivenNameKey, CNContactPhoneNumbersKey,CNContactFamilyNameKey] as [CNKeyDescriptor]
    
    let request = CNContactFetchRequest(keysToFetch: keys)
    
//    var nuevoContacto = CNMutableContact()
    
    do {
        try store.enumerateContacts(with: request, usingBlock: { contacto, resultado in
            print(contacto.givenName)
            if contacto.givenName == "Ferran" {
                guard let nuevoContacto = contacto.mutableCopy() as? CNMutableContact else { return }
                nuevoContacto.familyName = "Español Amigo"
                
                let saveRequest = CNSaveRequest()
                
                saveRequest.update(nuevoContacto) //.delete .add
                
                do {
                    try store.execute(saveRequest)
                } catch {
                    print("Saving contact failed, error: \(error)")
                    // Handle the error
                }
            }
        })
    }
    catch
    {
        print("Error")
    }
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
