create or replace view aggJoin2939610319807949874 as (
with aggView1938079533505596144 as (select id as v26, name as v47 from name as n)
select movie_id as v3, v47 from cast_info as ci, aggView1938079533505596144 where ci.person_id=aggView1938079533505596144.v26);
create or replace view aggJoin1129328633046950123 as (
with aggView6810526182004503102 as (select id as v3 from title as t)
select v3, v47 from aggJoin2939610319807949874 join aggView6810526182004503102 using(v3));
create or replace view aggJoin3750003719637225372 as (
with aggView6373512173215155826 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView6373512173215155826 where mc.company_id=aggView6373512173215155826.v20);
create or replace view aggJoin4826321303504529666 as (
with aggView6602206497095858524 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView6602206497095858524 where mk.keyword_id=aggView6602206497095858524.v25);
create or replace view aggJoin3715548419503642605 as (
with aggView2138340156169159790 as (select v3 from aggJoin4826321303504529666 group by v3)
select v3 from aggJoin3750003719637225372 join aggView2138340156169159790 using(v3));
create or replace view aggJoin9000073490630669328 as (
with aggView3505635867657309505 as (select v3 from aggJoin3715548419503642605 group by v3)
select v47 as v47 from aggJoin1129328633046950123 join aggView3505635867657309505 using(v3));
select MIN(v47) as v47 from aggJoin9000073490630669328;
