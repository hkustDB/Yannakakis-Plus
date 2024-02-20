## AggReduce Phase: 

# AggReduce153
# 1. aggView
create or replace view aggView5689479824273267922 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin4045305070008386746 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView5689479824273267922 where Person_likes_Message.MessageId=aggView5689479824273267922.v1;

# AggReduce154
# 1. aggView
create or replace view aggView4725588682416885228 as select v1, SUM(annot) as annot from aggJoin4045305070008386746 group by v1;
# 2. aggJoin
create or replace view aggJoin1718138224763471964 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView4725588682416885228 where Comment_replyOf_Message.ParentMessageId=aggView4725588682416885228.v1;

# AggReduce155
# 1. aggView
create or replace view aggView5739413915669357357 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin6255884416334575056 as select aggJoin1718138224763471964.annot * aggView5739413915669357357.annot as annot from aggJoin1718138224763471964 join aggView5739413915669357357 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin6255884416334575056;

# drop view aggView5689479824273267922, aggJoin4045305070008386746, aggView4725588682416885228, aggJoin1718138224763471964, aggView5739413915669357357, aggJoin6255884416334575056;
