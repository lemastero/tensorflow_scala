/* Copyright 2017-19, Emmanouil Antonios Platanios. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */

package org.platanios.tensorflow.api.implicits.ops

import org.platanios.tensorflow.api.ops.UntypedOp

trait ControlFlowImplicits {
  implicit class ControlFlowOps(val op: UntypedOp) {
    /** Returns `true` if the provided op is within a cond statement. */
    def isInCond: Boolean = {
      op.controlFlowContext.flatMap(_.condContext).isDefined
    }

    /** Returns `true` if the provided op is within a while loop statement. */
    def isInWhileLoop: Boolean = {
      op.controlFlowContext.flatMap(_.whileLoopContext()).isDefined
    }

    /** Returns `true` if the provided op is within an XLA control flow context. */
    def isInXLAContext: Boolean = {
      val xlaCompile = {
        try {
          op.booleanAttribute("_XlaCompile")
        } catch {
          case _: IllegalArgumentException => false
        }
      }
      xlaCompile || op.controlFlowContext.flatMap(_.xlaContext).isDefined
    }
  }
}
