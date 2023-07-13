/*
 * Copyright (c) 2023, WSO2 LLC. (http://www.wso2.com).
 *
 * WSO2 LLC. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package org.wso2.carbon.identity.oauth2.grant.rest.endpoint.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonCreator;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import javax.validation.constraints.*;


import io.swagger.annotations.*;
import java.util.Objects;
import javax.validation.Valid;
import javax.xml.bind.annotation.*;

public class AuthenticatedAuthenticator  {
  
    private Integer stepNo;
    private String authenticatorName;

    /**
    **/
    public AuthenticatedAuthenticator stepNo(Integer stepNo) {

        this.stepNo = stepNo;
        return this;
    }
    
    @ApiModelProperty(example = "1", value = "")
    @JsonProperty("stepNo")
    @Valid
    public Integer getStepNo() {
        return stepNo;
    }
    public void setStepNo(Integer stepNo) {
        this.stepNo = stepNo;
    }

    /**
    **/
    public AuthenticatedAuthenticator authenticatorName(String authenticatorName) {

        this.authenticatorName = authenticatorName;
        return this;
    }
    
    @ApiModelProperty(example = "IdentifierExecutor", value = "")
    @JsonProperty("authenticatorName")
    @Valid
    public String getAuthenticatorName() {
        return authenticatorName;
    }
    public void setAuthenticatorName(String authenticatorName) {
        this.authenticatorName = authenticatorName;
    }



    @Override
    public boolean equals(java.lang.Object o) {

        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        AuthenticatedAuthenticator authenticatedAuthenticator = (AuthenticatedAuthenticator) o;
        return Objects.equals(this.stepNo, authenticatedAuthenticator.stepNo) &&
            Objects.equals(this.authenticatorName, authenticatedAuthenticator.authenticatorName);
    }

    @Override
    public int hashCode() {
        return Objects.hash(stepNo, authenticatorName);
    }

    @Override
    public String toString() {

        StringBuilder sb = new StringBuilder();
        sb.append("class AuthenticatedAuthenticator {\n");
        
        sb.append("    stepNo: ").append(toIndentedString(stepNo)).append("\n");
        sb.append("    authenticatorName: ").append(toIndentedString(authenticatorName)).append("\n");
        sb.append("}");
        return sb.toString();
    }

    /**
    * Convert the given object to string with each line indented by 4 spaces
    * (except the first line).
    */
    private String toIndentedString(java.lang.Object o) {

        if (o == null) {
            return "null";
        }
        return o.toString().replace("\n", "\n");
    }
}

