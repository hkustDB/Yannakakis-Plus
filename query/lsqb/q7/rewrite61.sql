## AggReduce Phase: 

# AggReduce183
# 1. aggView
create or replace view aggView8080142424371478850 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin6615423555308826628 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView8080142424371478850 where Message_hasTag_Tag.MessageId=aggView8080142424371478850.v1;

# AggReduce184
# 1. aggView
create or replace view aggView5084523262749693341 as select v1, SUM(annot) as annot from aggJoin6615423555308826628 group by v1;
# 2. aggJoin
create or replace view aggJoin6919936348600740462 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView5084523262749693341 where Person_likes_Message.MessageId=aggView5084523262749693341.v1;

# AggReduce185
# 1. aggView
create or replace view aggView5581618625623259156 as select v1, SUM(annot) as annot from aggJoin6919936348600740462 group by v1;
# 2. aggJoin
create or replace view aggJoin5197229208626988561 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView5581618625623259156 where Comment_replyOf_Message.ParentMessageId=aggView5581618625623259156.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin5197229208626988561;

# drop view aggView8080142424371478850, aggJoin6615423555308826628, aggView5084523262749693341, aggJoin6919936348600740462, aggView5581618625623259156, aggJoin5197229208626988561;
