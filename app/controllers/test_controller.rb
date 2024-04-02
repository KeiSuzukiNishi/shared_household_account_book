class TestController < ApplicationController
    def test_500
      # 500ステータスコードを返す
      head :internal_server_error
    end
  end