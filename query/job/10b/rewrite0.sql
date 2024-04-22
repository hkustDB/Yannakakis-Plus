create or replace view aggView7437678885642063716 as select id as v1, name as v2 from char_name as chn;
create or replace view aggJoin1652981016271993444 as (
with aggView4537765004980008057 as (select id as v22 from company_type as ct)
select movie_id as v31, company_id as v15 from movie_companies as mc, aggView4537765004980008057 where mc.company_type_id=aggView4537765004980008057.v22);
create or replace view aggJoin4312176216314855073 as (
with aggView3563793345545083638 as (select id as v15 from company_name as cn where country_code= '[ru]')
select v31 from aggJoin1652981016271993444 join aggView3563793345545083638 using(v15));
create or replace view aggJoin2126668167009925511 as (
with aggView8609375324248703937 as (select v31 from aggJoin4312176216314855073 group by v31)
select id as v31, title as v32, production_year as v35 from title as t, aggView8609375324248703937 where t.id=aggView8609375324248703937.v31 and production_year>2010);
create or replace view aggView8785819483360272127 as select v32, v31 from aggJoin2126668167009925511 group by v32,v31;
create or replace view aggJoin8027821831499944993 as (
with aggView6657917228060198522 as (select v31, MIN(v32) as v44 from aggView8785819483360272127 group by v31)
select person_role_id as v1, note as v12, role_id as v29, v44 from cast_info as ci, aggView6657917228060198522 where ci.movie_id=aggView6657917228060198522.v31 and note LIKE '%(producer)%');
create or replace view aggJoin5751181134294191645 as (
with aggView5995458341544102740 as (select id as v29 from role_type as rt where role= 'actor')
select v1, v12, v44 from aggJoin8027821831499944993 join aggView5995458341544102740 using(v29));
create or replace view aggJoin4182208213703267890 as (
with aggView752508752721469104 as (select v1, MIN(v44) as v44 from aggJoin5751181134294191645 group by v1,v44)
select v2, v44 from aggView7437678885642063716 join aggView752508752721469104 using(v1));
select MIN(v2) as v43,MIN(v44) as v44 from aggJoin4182208213703267890;
