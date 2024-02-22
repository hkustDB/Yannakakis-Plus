create or replace view aggView1522891658592633503 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin3442008477907908426 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView1522891658592633503 where Person_likes_Message.MessageId=aggView1522891658592633503.v1;
create or replace view aggView5902704512664353553 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin6583877631540773404 as select v1, aggJoin3442008477907908426.annot * aggView5902704512664353553.annot as annot from aggJoin3442008477907908426 join aggView5902704512664353553 using(v1);
create or replace view aggView378451410144234410 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin7716542921712735472 as select aggJoin6583877631540773404.annot * aggView378451410144234410.annot as annot from aggJoin6583877631540773404 join aggView378451410144234410 using(v1);
select SUM(annot) as v9 from aggJoin7716542921712735472;
