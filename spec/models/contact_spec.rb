require 'rails_helper'

describe Contact do
  it "is valid with a firstname, lastname, and email" do
    contact = Contact.new(
      firstname: 'Aaron',
      lastname: 'Sumner',
      email: 'tester@example.com'
    )
    expect(contact).to be_valid
  end
  it "is invalid without a firstname" do
    contact = Contact.new(firstname: nil)
    contact.valid?
    expect(contact.errors[:firstname]).to include("can't be blank")
  end
  it "is invalid without a lastname" do
    contact = Contact.new(lastname: nil)
    contact.valid?
    expect(contact.errors[:lastname]).to include("can't be blank")
  end
  it "is invalid without an email address" do
    contact = Contact.new(email: nil)
    contact.valid?
    expect(contact.errors[:email]).to include("can't be blank")
  end
  it "is invalid with a duplicate email address" do
    Contact.create(
      firstname: 'Joe', lastname: 'Tucker',
      email: 'tester@example.com'
    )
    contact = Contact.create(
      firstname: 'Jane', lastname: 'Tester',
      email: 'tester@example.com')
    expect(contact.errors[:email]).to include("has already been taken")
  end
  it "returns a contact's full name as a string" do
    contact = Contact.new(
      firstname: 'Aaron',
      lastname: 'Sumner',
      email: 'tester@example.com'
    )
    expect(contact.name).to eq 'Aaron Sumner'
  end
  describe 'filter the last name by letter' do
    before :each do
      @smith = Contact.create(
        firstname: 'Jane', lastname: 'Smith',
        email: 'jane@example.com')
      @johnson = Contact.create(
        firstname: 'Tim', lastname: 'Johnson',
        email: 'tim@example.com')
      @foster = Contact.create(
        firstname: 'Anthony', lastname: 'Foster',
        email: 'tony@example.com')
      @franklin = Contact.create(
        firstname: 'Anthony', lastname: 'Franklin',
        email: 'thing@example.com')
    end

    context 'with matching letters' do
      it "returns a sorted array of results that match" do
        expect(Contact.by_letter('F')).to eq [@foster, @franklin]
      end
    end
    context 'non-matching words' do
      it 'omits the results that do not match' do
        expect(Contact.by_letter('F')).not_to include @smith
      end
    end
  end
end
