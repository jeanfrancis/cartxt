feature "Driver connects with their email address", :txt do
  let!(:car) { create :car }
  let!(:sharer) { create :sharer, balance: 35 }

  context 'and they have signed up on the site' do
    let!(:user) { create :user }

    scenario "The sharer registers their email address and it shows on the site", js: true do
      expect("email #{user.email}").to produce_response "Recorded your email address as #{user.email}. You can now check your balance on the site: http://example.org/"

      signin(user.email, user.password)

      visit root_path

      expect(page).to have_content("$35.00")
    end
  end

  context 'but they have not signed up' do
    scenario "They are given the link to sign up" do
      address = "test@example.com"

      expect("email #{address}").to produce_response "Recorded your email address as #{address}. Visit http://example.org/users/sign_up and register that address."
    end
  end
end
