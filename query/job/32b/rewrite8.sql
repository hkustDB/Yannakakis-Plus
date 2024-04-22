create or replace view aggJoin6562779890481430067 as (
with aggView63232392838930016 as (select id as v13, title as v38 from title as t1)
select movie_id as v13, linked_movie_id as v11, link_type_id as v4, v38 from movie_link as ml, aggView63232392838930016 where ml.movie_id=aggView63232392838930016.v13);
create or replace view aggJoin3487897056006293403 as (
with aggView4797503145623074188 as (select id as v11, title as v39 from title as t2)
select v13, v4, v38, v39 from aggJoin6562779890481430067 join aggView4797503145623074188 using(v11));
create or replace view aggJoin4686708760366758094 as (
with aggView8927514567086698884 as (select id as v4, link as v37 from link_type as lt)
select v13, v38, v39, v37 from aggJoin3487897056006293403 join aggView8927514567086698884 using(v4));
create or replace view aggJoin7842296919073221922 as (
with aggView5816348827288627325 as (select v13, MIN(v38) as v38, MIN(v39) as v39, MIN(v37) as v37 from aggJoin4686708760366758094 group by v13,v37,v38,v39)
select keyword_id as v8, v38, v39, v37 from movie_keyword as mk, aggView5816348827288627325 where mk.movie_id=aggView5816348827288627325.v13);
create or replace view aggJoin1988134272239840865 as (
with aggView5345511992840501839 as (select id as v8 from keyword as k where keyword= 'character-name-in-title')
select v38, v39, v37 from aggJoin7842296919073221922 join aggView5345511992840501839 using(v8));
select MIN(v37) as v37,MIN(v38) as v38,MIN(v39) as v39 from aggJoin1988134272239840865;
