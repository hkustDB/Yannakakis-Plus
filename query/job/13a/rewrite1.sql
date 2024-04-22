create or replace view aggJoin1815915405106267687 as (
with aggView4189967612898697601 as (select id as v8 from company_type as ct where kind= 'production companies')
select movie_id as v22, company_id as v1 from movie_companies as mc, aggView4189967612898697601 where mc.company_type_id=aggView4189967612898697601.v8);
create or replace view aggJoin7638754740889986208 as (
with aggView2236781292941822951 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView2236781292941822951 where miidx.info_type_id=aggView2236781292941822951.v10);
create or replace view aggJoin3610784088777504791 as (
with aggView3916662628363057460 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22, info as v24 from movie_info as mi, aggView3916662628363057460 where mi.info_type_id=aggView3916662628363057460.v12);
create or replace view aggView3441501328798000555 as select v24, v22 from aggJoin3610784088777504791 group by v24,v22;
create or replace view aggJoin1930538596849449584 as (
with aggView7239395607632807524 as (select id as v1 from company_name as cn where country_code= '[de]')
select v22 from aggJoin1815915405106267687 join aggView7239395607632807524 using(v1));
create or replace view aggJoin59048408835179029 as (
with aggView3122883662932650432 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView3122883662932650432 where t.kind_id=aggView3122883662932650432.v14);
create or replace view aggView8454313229130851503 as select v22, v32 from aggJoin59048408835179029 group by v22,v32;
create or replace view aggJoin787942744486437595 as (
with aggView4070531175560486712 as (select v22 from aggJoin1930538596849449584 group by v22)
select v22, v29 from aggJoin7638754740889986208 join aggView4070531175560486712 using(v22));
create or replace view aggView3816492032323336864 as select v22, v29 from aggJoin787942744486437595 group by v22,v29;
create or replace view aggJoin5646293572135892560 as (
with aggView8844305399272410793 as (select v22, MIN(v32) as v45 from aggView8454313229130851503 group by v22)
select v22, v29, v45 from aggView3816492032323336864 join aggView8844305399272410793 using(v22));
create or replace view aggJoin1936323883445035751 as (
with aggView4405152881991257305 as (select v22, MIN(v45) as v45, MIN(v29) as v44 from aggJoin5646293572135892560 group by v22,v45)
select v24, v45, v44 from aggView3441501328798000555 join aggView4405152881991257305 using(v22));
select MIN(v24) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin1936323883445035751;
