# frozen_string_literal: true

class PwaController < ApplicationController
  protect_from_forgery except: :service_worker
  layout false

  def service_worker
    response.headers['Cache-Control'] = 'no-cache'
  end

  def manifest
    response.headers['Cache-Control'] = 'no-cache'

    render json: {
      name: 'Hayate',
      short_name: 'Hayate',
      description: 'Hayate is an app that makes your life more controllable.',
      theme_color: '#0492c2',
      background_color: '#0492c2',
      display: 'standalone',
      orientation: 'portrait',
      scope: '/',
      start_url: '/',
      icons: [
        {
          src: '/icon.png',
          type: 'image/png',
          sizes: '512x512'
        },
        {
          src: '/icon.png',
          type: 'image/png',
          sizes: '512x512',
          purpose: 'maskable'
        }
      ],
      shortcuts: [],
      screenshots: [],
      categories: %w[productivity utilities]
    }
  end
end
