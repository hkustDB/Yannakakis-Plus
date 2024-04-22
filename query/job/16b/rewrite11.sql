create or replace view aggView3079952906165105460 as select title as v44, id as v11 from title as t;
create or replace view aggJoin8473061870624595229 as (
with aggView2098557620426855761 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView2098557620426855761 where an.person_id=aggView2098557620426855761.v2);
create or replace view aggView2860130735171824646 as select v3, v2 from aggJoin8473061870624595229 group by v3,v2;
create or replace view aggJoin4456580350643668633 as (
with aggView4468827033605099245 as (select v2, MIN(v3) as v55 from aggView2860130735171824646 group by v2)
select movie_id as v11, v55 from cast_info as ci, aggView4468827033605099245 where ci.person_id=aggView4468827033605099245.v2);
create or replace view aggJoin158013375867687516 as (
with aggView6488104071296035784 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView6488104071296035784 where mc.company_id=aggView6488104071296035784.v28);
create or replace view aggJoin1853705776436953648 as (
with aggView3969987663801725573 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView3969987663801725573 where mk.keyword_id=aggView3969987663801725573.v33);
create or replace view aggJoin441112042891839199 as (
with aggView3666510563668909301 as (select v11 from aggJoin1853705776436953648 group by v11)
select v11, v55 as v55 from aggJoin4456580350643668633 join aggView3666510563668909301 using(v11));
create or replace view aggJoin3979430168879678013 as (
with aggView1481445045818064709 as (select v11 from aggJoin158013375867687516 group by v11)
select v11, v55 as v55 from aggJoin441112042891839199 join aggView1481445045818064709 using(v11));
create or replace view aggJoin3251949621945046181 as (
with aggView5671196335781341152 as (select v11, MIN(v55) as v55 from aggJoin3979430168879678013 group by v11,v55)
select v44, v55 from aggView3079952906165105460 join aggView5671196335781341152 using(v11));
select MIN(v55) as v55,MIN(v44) as v56 from aggJoin3251949621945046181;
