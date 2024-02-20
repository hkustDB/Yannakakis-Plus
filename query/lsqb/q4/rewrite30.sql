## AggReduce Phase: 

# AggReduce90
# 1. aggView
create or replace view aggView2047909403171435417 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin4124484407395558295 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView2047909403171435417 where Message_hasTag_Tag.MessageId=aggView2047909403171435417.v1;

# AggReduce91
# 1. aggView
create or replace view aggView5698469979974747087 as select v1, SUM(annot) as annot from aggJoin4124484407395558295 group by v1;
# 2. aggJoin
create or replace view aggJoin6412670740835724484 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView5698469979974747087 where Comment_replyOf_Message.ParentMessageId=aggView5698469979974747087.v1;

# AggReduce92
# 1. aggView
create or replace view aggView272497637918609706 as select v1, SUM(annot) as annot from aggJoin6412670740835724484 group by v1;
# 2. aggJoin
create or replace view aggJoin1610308261221294112 as select annot from Person_likes_Message as Person_likes_Message, aggView272497637918609706 where Person_likes_Message.MessageId=aggView272497637918609706.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin1610308261221294112;

# drop view aggView2047909403171435417, aggJoin4124484407395558295, aggView5698469979974747087, aggJoin6412670740835724484, aggView272497637918609706, aggJoin1610308261221294112;
