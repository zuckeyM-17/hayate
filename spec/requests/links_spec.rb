# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Links', type: :request do
  user = User.create!

  let(:user) { User.create! }

  describe 'GET /index' do
    it 'HTTPステータス 200 を返す' do
      get '/links'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE /links/:id' do
    it 'HTTPステータス 302 を返す' do
      link = Link.create!(title: 'test', url: 'http://example.com', user: user)
      delete "/links/#{link.id}"
      expect(response).to have_http_status(:found)
    end

    it 'リンクが削除される' do
      link = Link.create!(title: 'test', url: 'http://example.com', user: user)
      expect do
        delete "/links/#{link.id}"
      end.to change { Link.count }.by(-1)
    end
  end

  describe 'PATCH /links/:id/read' do
    it 'HTTPステータス 302 を返す' do
      link = Link.create!(title: 'test', url: 'http://example.com', user: user)
      patch "/links/#{link.id}/read"
      expect(response).to have_http_status(:found)
    end

    it 'リンクが削除される' do
      link = Link.create!(title: 'test', url: 'http://example.com', user: user)
      expect do
        patch "/links/#{link.id}/read"
      end.to change { link.reload.read_at }.from(nil).to be_present
    end
  end
end
