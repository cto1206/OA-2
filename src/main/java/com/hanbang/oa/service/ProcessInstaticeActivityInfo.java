package com.hanbang.oa.service;

import java.util.List;

import org.jbpm.api.history.HistoryActivityInstance;
import org.jbpm.api.model.ActivityCoordinates;

public class ProcessInstaticeActivityInfo {
	 private List<ActivityInfo> activeActivityInfos; // 处于活动的节点信息   
	  private List<ActivityInfo> processedActivityInfos; // 已经处理过的节点信息   
	  
	  /**  
	   * @param activeActivityInfos  
	   * @param processedActivityInfos  
	   */  
	  public ProcessInstaticeActivityInfo(List<ActivityInfo> activeActivityInfos,   
	      List<ActivityInfo> processedActivityInfos) {   
	    this.activeActivityInfos = activeActivityInfos;   
	    this.processedActivityInfos = processedActivityInfos;   
	  }   
	  
	  public static class ActivityInfo {   
	    private ActivityCoordinates coordinates;   
	    private HistoryActivityInstance activityInstance;   
	  
	    /**  
	     * @param coordinates  
	     */  
	    public ActivityInfo(ActivityCoordinates coordinates) {   
	      this.coordinates = coordinates;   
	    }   
	  
	    /**  
	     * @param coordinates  
	     * @param activityInstance  
	     */  
	    public ActivityInfo(ActivityCoordinates coordinates, HistoryActivityInstance activityInstance) {   
	      this.coordinates = coordinates;   
	      this.activityInstance = activityInstance;   
	    }   
	  
	    /**  
	     * @return the coordinates  
	     */  
	    public ActivityCoordinates getCoordinates() {   
	      return coordinates;   
	    }   
	  
	    /**  
	     * @param coordinates  
	     *          the coordinates to set  
	     */  
	    public void setCoordinates(ActivityCoordinates coordinates) {   
	      this.coordinates = coordinates;   
	    }   
	  
	    /**  
	     * @return the activityInstance  
	     */  
	    public HistoryActivityInstance getActivityInstance() {   
	      return activityInstance;   
	    }   
	  
	    /**  
	     * @param activityInstance  
	     *          the activityInstance to set  
	     */  
	    public void setActivityInstance(HistoryActivityInstance activityInstance) {   
	      this.activityInstance = activityInstance;   
	    }   
	  }   
	  
	  /**  
	   * @return the activeActivityInfos  
	   */  
	  public List<ActivityInfo> getActiveActivityInfos() {   
	    return activeActivityInfos;   
	  }   
	  
	  /**  
	   * @return the processedActivityInfos  
	   */  
	  public List<ActivityInfo> getProcessedActivityInfos() {   
	    return processedActivityInfos;   
	  }   

}
