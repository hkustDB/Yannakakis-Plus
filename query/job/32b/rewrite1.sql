create or replace view aggView5345840147098636928 as select id as v11, title as v26 from title as t2;
create or replace view aggJoin7681258561040042199 as (
with aggView7415197357431262608 as (select id as v8 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v13 from movie_keyword as mk, aggView7415197357431262608 where mk.keyword_id=aggView7415197357431262608.v8);
create or replace view aggJoin6039369391757753189 as (
with aggView6398238375957124020 as (select v13 from aggJoin7681258561040042199 group by v13)
select id as v13, title as v14 from title as t1, aggView6398238375957124020 where t1.id=aggView6398238375957124020.v13);
create or replace view aggView4004583410792998067 as select v13, v14 from aggJoin6039369391757753189 group by v13,v14;
create or replace view aggJoin1636097280121837242 as (
with aggView3050320003761907773 as (select v11, MIN(v26) as v39 from aggView5345840147098636928 group by v11)
select movie_id as v13, link_type_id as v4, v39 from movie_link as ml, aggView3050320003761907773 where ml.linked_movie_id=aggView3050320003761907773.v11);
create or replace view aggJoin5169745186096387137 as (
with aggView964656467438479619 as (select id as v4, link as v37 from link_type as lt)
select v13, v39, v37 from aggJoin1636097280121837242 join aggView964656467438479619 using(v4));
create or replace view aggJoin5539489806077956113 as (
with aggView8354499667487025576 as (select v13, MIN(v39) as v39, MIN(v37) as v37 from aggJoin5169745186096387137 group by v13,v37,v39)
select v14, v39, v37 from aggView4004583410792998067 join aggView8354499667487025576 using(v13));
select MIN(v37) as v37,MIN(v14) as v38,MIN(v39) as v39 from aggJoin5539489806077956113;
