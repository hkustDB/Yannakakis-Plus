create or replace view aggView6604685392251423754 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin7539751025330851779 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView6604685392251423754 where Message_hasCreator_Person.MessageId=aggView6604685392251423754.v1;
create or replace view aggView7181295126488435872 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin6771055317786934923 as select v1, aggJoin7539751025330851779.annot * aggView7181295126488435872.annot as annot from aggJoin7539751025330851779 join aggView7181295126488435872 using(v1);
create or replace view aggView4451773523024383013 as select v1, SUM(annot) as annot from aggJoin6771055317786934923 group by v1;
create or replace view aggJoin5921497793325313948 as select annot from Person_likes_Message as Person_likes_Message, aggView4451773523024383013 where Person_likes_Message.MessageId=aggView4451773523024383013.v1;
select SUM(annot) as v9 from aggJoin5921497793325313948;
