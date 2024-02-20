## AggReduce Phase: 

# AggReduce75
# 1. aggView
create or replace view aggView2648357939673236487 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin7642255327636157491 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView2648357939673236487 where Message_hasTag_Tag.MessageId=aggView2648357939673236487.v1;

# AggReduce76
# 1. aggView
create or replace view aggView3388887292253633246 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin4277915563011792181 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView3388887292253633246 where Message_hasCreator_Person.MessageId=aggView3388887292253633246.v1;

# AggReduce77
# 1. aggView
create or replace view aggView5584176694104429980 as select v1, SUM(annot) as annot from aggJoin4277915563011792181 group by v1;
# 2. aggJoin
create or replace view aggJoin3966890845859189653 as select aggJoin7642255327636157491.annot * aggView5584176694104429980.annot as annot from aggJoin7642255327636157491 join aggView5584176694104429980 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin3966890845859189653;

# drop view aggView2648357939673236487, aggJoin7642255327636157491, aggView3388887292253633246, aggJoin4277915563011792181, aggView5584176694104429980, aggJoin3966890845859189653;
