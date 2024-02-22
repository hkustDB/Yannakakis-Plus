create or replace view aggView588859016086900578 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin5134240246678234525 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView588859016086900578 where Person_likes_Message.MessageId=aggView588859016086900578.v1;
create or replace view aggView5367745685922528618 as select v1, SUM(annot) as annot from aggJoin5134240246678234525 group by v1;
create or replace view aggJoin2436831199700328853 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView5367745685922528618 where Message_hasTag_Tag.MessageId=aggView5367745685922528618.v1;
create or replace view aggView6819005855950301264 as select v1, SUM(annot) as annot from aggJoin2436831199700328853 group by v1;
create or replace view aggJoin7885300692524930667 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView6819005855950301264 where Comment_replyOf_Message.ParentMessageId=aggView6819005855950301264.v1;
select SUM(annot) as v9 from aggJoin7885300692524930667;
