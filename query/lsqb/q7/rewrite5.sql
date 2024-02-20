## AggReduce Phase: 

# AggReduce15
# 1. aggView
create or replace view aggView3733184012542214271 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin2527991231907444434 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView3733184012542214271 where Message_hasTag_Tag.MessageId=aggView3733184012542214271.v1;

# AggReduce16
# 1. aggView
create or replace view aggView5455893726402028207 as select v1, SUM(annot) as annot from aggJoin2527991231907444434 group by v1;
# 2. aggJoin
create or replace view aggJoin6795156057434904723 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView5455893726402028207 where Person_likes_Message.MessageId=aggView5455893726402028207.v1;

# AggReduce17
# 1. aggView
create or replace view aggView8428449400278481094 as select v1, SUM(annot) as annot from aggJoin6795156057434904723 group by v1;
# 2. aggJoin
create or replace view aggJoin3111524019465888166 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView8428449400278481094 where Message_hasCreator_Person.MessageId=aggView8428449400278481094.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin3111524019465888166;

# drop view aggView3733184012542214271, aggJoin2527991231907444434, aggView5455893726402028207, aggJoin6795156057434904723, aggView8428449400278481094, aggJoin3111524019465888166;
