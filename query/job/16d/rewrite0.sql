create or replace view aggJoin1730197930034881254 as (
with aggView839683946300125862 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView839683946300125862 where mk.keyword_id=aggView839683946300125862.v33);
create or replace view aggJoin312530834575401831 as (
with aggView3186026955973220116 as (select v11 from aggJoin1730197930034881254 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView3186026955973220116 where t.id=aggView3186026955973220116.v11 and episode_nr>=5 and episode_nr<100);
create or replace view aggView7789473844724698522 as select v44, v11 from aggJoin312530834575401831 group by v44,v11;
create or replace view aggJoin970716681568966696 as (
with aggView7752717376096819124 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView7752717376096819124 where an.person_id=aggView7752717376096819124.v2);
create or replace view aggView6823653050864167400 as select v2, v3 from aggJoin970716681568966696 group by v2,v3;
create or replace view aggJoin8189219480458570086 as (
with aggView3005514804364311068 as (select v11, MIN(v44) as v56 from aggView7789473844724698522 group by v11)
select person_id as v2, movie_id as v11, v56 from cast_info as ci, aggView3005514804364311068 where ci.movie_id=aggView3005514804364311068.v11);
create or replace view aggJoin1219812048996246661 as (
with aggView6826206607029754166 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView6826206607029754166 where mc.company_id=aggView6826206607029754166.v28);
create or replace view aggJoin1576757406362871909 as (
with aggView1970362485964765972 as (select v11 from aggJoin1219812048996246661 group by v11)
select v2, v56 as v56 from aggJoin8189219480458570086 join aggView1970362485964765972 using(v11));
create or replace view aggJoin3048973039524131153 as (
with aggView689629919226904471 as (select v2, MIN(v56) as v56 from aggJoin1576757406362871909 group by v2,v56)
select v3, v56 from aggView6823653050864167400 join aggView689629919226904471 using(v2));
select MIN(v3) as v55,MIN(v56) as v56 from aggJoin3048973039524131153;
