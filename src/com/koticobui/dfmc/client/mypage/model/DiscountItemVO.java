package com.koticobui.dfmc.client.mypage.model;


/**
 * The type Discount item vo.
 */
public class DiscountItemVO {
	
	private String[] arrDiscountItemKey;
	
	private String[] arrAssignScoreItemKey;


	/**
	 * Get arr discount item key string [ ].
	 *
	 * @return the string [ ]
	 */
	public String[] getArrDiscountItemKey() {
		return arrDiscountItemKey;
	}

	/**
	 * Sets arr discount item key.
	 *
	 * @param arrDiscountItemKey the arr discount item key
	 */
	public void setArrDiscountItemKey(String[] arrDiscountItemKey) {
		this.arrDiscountItemKey = arrDiscountItemKey;
	}

	/**
	 * Get arr assign score item key string [ ].
	 *
	 * @return the string [ ]
	 */
	public String[] getArrAssignScoreItemKey() {
		return arrAssignScoreItemKey;
	}

	/**
	 * Sets arr assign score item key.
	 *
	 * @param arrAssignScoreItemKey the arr assign score item key
	 */
	public void setArrAssignScoreItemKey(String[] arrAssignScoreItemKey) {
		this.arrAssignScoreItemKey = arrAssignScoreItemKey;
	}

}
