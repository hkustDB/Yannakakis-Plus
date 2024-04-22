create or replace view aggJoin3644316470151520326 as (
with aggView784102756895438323 as (select id as v26, name as v47 from name as n where name LIKE '%Bert%')
select movie_id as v3, v47 from cast_info as ci, aggView784102756895438323 where ci.person_id=aggView784102756895438323.v26);
create or replace view aggJoin3041227148997018842 as (
with aggView1106993644569065980 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView1106993644569065980 where mc.company_id=aggView1106993644569065980.v20);
create or replace view aggJoin4369280836069443268 as (
with aggView1982128146440977253 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView1982128146440977253 where mk.keyword_id=aggView1982128146440977253.v25);
create or replace view aggJoin1178116854630818078 as (
with aggView3446272783991998767 as (select id as v3 from title as t)
select v3 from aggJoin4369280836069443268 join aggView3446272783991998767 using(v3));
create or replace view aggJoin336140642585256671 as (
with aggView2026864813856181897 as (select v3 from aggJoin1178116854630818078 group by v3)
select v3 from aggJoin3041227148997018842 join aggView2026864813856181897 using(v3));
create or replace view aggJoin1438642653438518679 as (
with aggView4425447432663613499 as (select v3 from aggJoin336140642585256671 group by v3)
select v47 as v47 from aggJoin3644316470151520326 join aggView4425447432663613499 using(v3));
select MIN(v47) as v47 from aggJoin1438642653438518679;
