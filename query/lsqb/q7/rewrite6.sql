## AggReduce Phase: 

# AggReduce18
# 1. aggView
create or replace view aggView6108381191917088070 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin3101556996107010299 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView6108381191917088070 where Person_likes_Message.MessageId=aggView6108381191917088070.v1;

# AggReduce19
# 1. aggView
create or replace view aggView4407886597383226832 as select v1, SUM(annot) as annot from aggJoin3101556996107010299 group by v1;
# 2. aggJoin
create or replace view aggJoin8055544446380879791 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView4407886597383226832 where Comment_replyOf_Message.ParentMessageId=aggView4407886597383226832.v1;

# AggReduce20
# 1. aggView
create or replace view aggView8784852520897419224 as select v1, SUM(annot) as annot from aggJoin8055544446380879791 group by v1;
# 2. aggJoin
create or replace view aggJoin8553139903549587638 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView8784852520897419224 where Message_hasTag_Tag.MessageId=aggView8784852520897419224.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin8553139903549587638;

# drop view aggView6108381191917088070, aggJoin3101556996107010299, aggView4407886597383226832, aggJoin8055544446380879791, aggView8784852520897419224, aggJoin8553139903549587638;
