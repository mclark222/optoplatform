module  Finance
  class SubmitPlaidItem 
    include Interactor

    def call
      create_plaid_item
      fetch_and_save_accounts
      fetch_and_save_transactions
    end

    private

    def create_plaid_item
      plaid_item = PlaidItem.new(
        plaid_access_token: context.plaid_access_token,
        plaid_item_id: context.plaid_item_id,
        user: context.user
      )
      plaid_item.save!
      context.plaid_item = plaid_item
    end

    def fetch_and_save_accounts
      response = PlaidClient.new.get_accounts(context.plaid_access_token)
      response.accounts.each do |account|
        Account.create!(
          user: context.user,
          type_plaid: account.type,
          subtype_plaid: account.subtype,
          account_type: account.subtype,
          plaid_account_id: account.account_id,
          available_balance_plaid: account.balances.available,
          current_balance_plaid: account.balances.current,
          mask_plaid: account.mask,
          name_plaid: account.name,
          official_name_plaid: account.official_name,
          item: context.plaid_item
        )
      end
    end

    def fetch_and_save_transactions
      PlaidClient.new.sync_transactions(
        context.plaid_item.reload
      )
    end
  end
end
