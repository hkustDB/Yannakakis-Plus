create or replace view aggJoin5502649495351750416 as (
with aggView7298606817955844783 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView7298606817955844783 where mc.company_id=aggView7298606817955844783.v20);
create or replace view aggJoin3086457287202630796 as (
with aggView6951744804050831771 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView6951744804050831771 where mk.keyword_id=aggView6951744804050831771.v25);
create or replace view aggJoin6721879308677875425 as (
with aggView5616237589216552180 as (select v3 from aggJoin3086457287202630796 group by v3)
select id as v3 from title as t, aggView5616237589216552180 where t.id=aggView5616237589216552180.v3);
create or replace view aggJoin388188339297000491 as (
with aggView8503214945033872313 as (select v3 from aggJoin6721879308677875425 group by v3)
select v3 from aggJoin5502649495351750416 join aggView8503214945033872313 using(v3));
create or replace view aggJoin7397816089028941233 as (
with aggView3040773676177807809 as (select v3 from aggJoin388188339297000491 group by v3)
select person_id as v26 from cast_info as ci, aggView3040773676177807809 where ci.movie_id=aggView3040773676177807809.v3);
create or replace view aggJoin668394830812859813 as (
with aggView1914838167524473227 as (select v26 from aggJoin7397816089028941233 group by v26)
select name as v27 from name as n, aggView1914838167524473227 where n.id=aggView1914838167524473227.v26 and name LIKE 'Z%');
create or replace view aggView2510022788510319657 as select v27 from aggJoin668394830812859813 group by v27;
select MIN(v27) as v47 from aggView2510022788510319657;
