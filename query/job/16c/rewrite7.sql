create or replace view aggJoin947919357467171338 as (
with aggView5164940956527248913 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView5164940956527248913 where an.person_id=aggView5164940956527248913.v2);
create or replace view aggJoin183495037945017664 as (
with aggView3913631880789075702 as (select v2, MIN(v3) as v55 from aggJoin947919357467171338 group by v2)
select movie_id as v11, v55 from cast_info as ci, aggView3913631880789075702 where ci.person_id=aggView3913631880789075702.v2);
create or replace view aggJoin186600866958882405 as (
with aggView1995986414356956683 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView1995986414356956683 where mk.keyword_id=aggView1995986414356956683.v33);
create or replace view aggJoin9197868820950360742 as (
with aggView6797752486921207344 as (select v11 from aggJoin186600866958882405 group by v11)
select movie_id as v11, company_id as v28 from movie_companies as mc, aggView6797752486921207344 where mc.movie_id=aggView6797752486921207344.v11);
create or replace view aggJoin5163208928001016384 as (
with aggView6021234914664329373 as (select id as v28 from company_name as cn where country_code= '[us]')
select v11 from aggJoin9197868820950360742 join aggView6021234914664329373 using(v28));
create or replace view aggJoin756283299354065445 as (
with aggView5214467661210489825 as (select v11 from aggJoin5163208928001016384 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView5214467661210489825 where t.id=aggView5214467661210489825.v11 and episode_nr<100);
create or replace view aggJoin205468536030591197 as (
with aggView7190884637865751863 as (select v11, MIN(v44) as v56 from aggJoin756283299354065445 group by v11)
select v55 as v55, v56 from aggJoin183495037945017664 join aggView7190884637865751863 using(v11));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin205468536030591197;
