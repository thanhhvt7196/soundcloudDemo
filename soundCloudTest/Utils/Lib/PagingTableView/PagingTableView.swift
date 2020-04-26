//
//  PagingTableView.swift
//  myNews
//
//  Created by kennyS on 2/2/20.
//  Copyright © 2020 kennyS. All rights reserved.
//

import UIKit

@objc public protocol PagingTableViewDelegate {
    @objc optional func didPaginate(_ tableView: PagingTableView, to page: Int)
    func paginate(_ tableView: PagingTableView, to page: Int)
}

open class PagingTableView: UITableView {
    private var loadingView: UIView!
    private var indicator: UIActivityIndicatorView!
    var page: Int = 0
    var previousItemCount: Int = 0
    
    weak var pagingDelegate: PagingTableViewDelegate?
    
    func reset() {
        page = 0
        previousItemCount = 0
//        pagingDelegate?.paginate(self, to: page)
    }
    
    private func paginate(_ tableView: PagingTableView, forIndexAt indexPath: IndexPath) {
        let itemCount = tableView.dataSource?.tableView(tableView, numberOfRowsInSection: indexPath.section) ?? 0
        guard itemCount > 0 else { return }
        guard indexPath.row == itemCount - 1 else { return }
        guard previousItemCount != itemCount else { return }
        page += 1
        previousItemCount = itemCount
        pagingDelegate?.paginate(self, to: page)
    }
    
    override open func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        paginate(self, forIndexAt: indexPath)
        return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
}
