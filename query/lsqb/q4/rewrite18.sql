## AggReduce Phase: 

# AggReduce54
# 1. aggView
create or replace view aggView3556744096883838333 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin7150942028602873032 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView3556744096883838333 where Comment_replyOf_Message.ParentMessageId=aggView3556744096883838333.v1;

# AggReduce55
# 1. aggView
create or replace view aggView1338112925660881879 as select v1, SUM(annot) as annot from aggJoin7150942028602873032 group by v1;
# 2. aggJoin
create or replace view aggJoin6490999474311232260 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView1338112925660881879 where Message_hasCreator_Person.MessageId=aggView1338112925660881879.v1;

# AggReduce56
# 1. aggView
create or replace view aggView1212850491946136412 as select v1, SUM(annot) as annot from aggJoin6490999474311232260 group by v1;
# 2. aggJoin
create or replace view aggJoin7114113580307793039 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView1212850491946136412 where Message_hasTag_Tag.MessageId=aggView1212850491946136412.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin7114113580307793039;

# drop view aggView3556744096883838333, aggJoin7150942028602873032, aggView1338112925660881879, aggJoin6490999474311232260, aggView1212850491946136412, aggJoin7114113580307793039;
