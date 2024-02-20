## AggReduce Phase: 

# AggReduce120
# 1. aggView
create or replace view aggView5127165351138322762 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin5692574088291223177 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView5127165351138322762 where Person_likes_Message.MessageId=aggView5127165351138322762.v1;

# AggReduce121
# 1. aggView
create or replace view aggView4571666527799648925 as select v1, SUM(annot) as annot from aggJoin5692574088291223177 group by v1;
# 2. aggJoin
create or replace view aggJoin6973196976676079958 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView4571666527799648925 where Message_hasTag_Tag.MessageId=aggView4571666527799648925.v1;

# AggReduce122
# 1. aggView
create or replace view aggView6961807134749851406 as select v1, SUM(annot) as annot from aggJoin6973196976676079958 group by v1;
# 2. aggJoin
create or replace view aggJoin1688382548575646166 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView6961807134749851406 where Message_hasCreator_Person.MessageId=aggView6961807134749851406.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin1688382548575646166;

# drop view aggView5127165351138322762, aggJoin5692574088291223177, aggView4571666527799648925, aggJoin6973196976676079958, aggView6961807134749851406, aggJoin1688382548575646166;
