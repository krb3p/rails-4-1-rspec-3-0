require 'rails_helper'

describe Phone do
  it "does not allow duplicate phone numbers for a contact" do
    contact = Contact.create(
      firstname: 'Joe', lastname: 'Tucker',
      email: 'tester@example.com'
    )
    contact.phones.create(
      phone_type: 'home',
      phone: '785-555-1234'
    )
    mobile_phone = contact.phones.build(
      phone_type: 'mobile',
      phone: '785-555-1234'
    )
    mobile_phone.valid?
    expect(mobile_phone.errors[:phone]).to include('has already been taken')
  end
  it "allows two contacts to share a phone number" do
    contact_1 = Contact.create(
      firstname: 'Joe', lastname: 'Tucker',
      email: 'tester@example.com'
    )
    contact_1.phones.create(
      phone_type: 'home',
      phone: '785-555-1234'
    )
    contact_2 = Contact.new
    contact_2_phone = contact_2.phones.build(
      phone_type: 'home',
      phone: '785-555-1234'
    )
    contact_2.valid?
    expect(contact_2_phone).to be_valid

  end
end
