## AggReduce Phase: 

# AggReduce108
# 1. aggView
create or replace view aggView7887771385549137352 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin7382596662521442734 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView7887771385549137352 where Message_hasCreator_Person.MessageId=aggView7887771385549137352.v1;

# AggReduce109
# 1. aggView
create or replace view aggView3606028731854870704 as select v1, SUM(annot) as annot from aggJoin7382596662521442734 group by v1;
# 2. aggJoin
create or replace view aggJoin7363341175616078014 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView3606028731854870704 where Person_likes_Message.MessageId=aggView3606028731854870704.v1;

# AggReduce110
# 1. aggView
create or replace view aggView5997722236491752680 as select v1, SUM(annot) as annot from aggJoin7363341175616078014 group by v1;
# 2. aggJoin
create or replace view aggJoin1450312177906730145 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView5997722236491752680 where Comment_replyOf_Message.ParentMessageId=aggView5997722236491752680.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin1450312177906730145;

# drop view aggView7887771385549137352, aggJoin7382596662521442734, aggView3606028731854870704, aggJoin7363341175616078014, aggView5997722236491752680, aggJoin1450312177906730145;
