create or replace view aggJoin5728342445892921605 as (
with aggView1024533601940190849 as (select id as v26, name as v47 from name as n where name LIKE 'X%')
select movie_id as v3, v47 from cast_info as ci, aggView1024533601940190849 where ci.person_id=aggView1024533601940190849.v26);
create or replace view aggJoin4516147321988157153 as (
with aggView8193498442569011478 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView8193498442569011478 where mk.keyword_id=aggView8193498442569011478.v25);
create or replace view aggJoin3756889382788888095 as (
with aggView8369722047522245513 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView8369722047522245513 where mc.company_id=aggView8369722047522245513.v20);
create or replace view aggJoin3256268293954593435 as (
with aggView3647735312019157654 as (select v3 from aggJoin4516147321988157153 group by v3)
select v3 from aggJoin3756889382788888095 join aggView3647735312019157654 using(v3));
create or replace view aggJoin5473661546566577425 as (
with aggView1756379476650339435 as (select v3 from aggJoin3256268293954593435 group by v3)
select id as v3 from title as t, aggView1756379476650339435 where t.id=aggView1756379476650339435.v3);
create or replace view aggJoin2765080434864008224 as (
with aggView3259493118340073046 as (select v3 from aggJoin5473661546566577425 group by v3)
select v47 as v47 from aggJoin5728342445892921605 join aggView3259493118340073046 using(v3));
select MIN(v47) as v47 from aggJoin2765080434864008224;
