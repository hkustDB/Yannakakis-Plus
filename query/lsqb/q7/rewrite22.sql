create or replace view aggView4706997174389524953 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin6573710014516480556 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView4706997174389524953 where Person_likes_Message.MessageId=aggView4706997174389524953.v1;
create or replace view aggView1421672372118861682 as select v1, SUM(annot) as annot from aggJoin6573710014516480556 group by v1;
create or replace view aggJoin7255278763060780846 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView1421672372118861682 where Message_hasCreator_Person.MessageId=aggView1421672372118861682.v1;
create or replace view aggView667538837126918214 as select v1, SUM(annot) as annot from aggJoin7255278763060780846 group by v1;
create or replace view aggJoin5910115108666450112 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView667538837126918214 where Message_hasTag_Tag.MessageId=aggView667538837126918214.v1;
select SUM(annot) as v9 from aggJoin5910115108666450112;
