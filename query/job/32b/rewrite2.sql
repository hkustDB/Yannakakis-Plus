create or replace view aggView8086788234660939630 as select id as v11, title as v26 from title as t2;
create or replace view aggJoin4136285350124783902 as (
with aggView8812849232828231554 as (select id as v8 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v13 from movie_keyword as mk, aggView8812849232828231554 where mk.keyword_id=aggView8812849232828231554.v8);
create or replace view aggJoin3616651825355821689 as (
with aggView5155845981193388782 as (select v13 from aggJoin4136285350124783902 group by v13)
select id as v13, title as v14 from title as t1, aggView5155845981193388782 where t1.id=aggView5155845981193388782.v13);
create or replace view aggView1247345029750791416 as select v13, v14 from aggJoin3616651825355821689 group by v13,v14;
create or replace view aggJoin2044242853045108511 as (
with aggView4552621508356500652 as (select v13, MIN(v14) as v38 from aggView1247345029750791416 group by v13)
select linked_movie_id as v11, link_type_id as v4, v38 from movie_link as ml, aggView4552621508356500652 where ml.movie_id=aggView4552621508356500652.v13);
create or replace view aggJoin2728074688802671195 as (
with aggView8883530061392285437 as (select v11, MIN(v26) as v39 from aggView8086788234660939630 group by v11)
select v4, v38 as v38, v39 from aggJoin2044242853045108511 join aggView8883530061392285437 using(v11));
create or replace view aggJoin8300876809396456484 as (
with aggView8141894429224473657 as (select v4, MIN(v38) as v38, MIN(v39) as v39 from aggJoin2728074688802671195 group by v4,v38,v39)
select link as v5, v38, v39 from link_type as lt, aggView8141894429224473657 where lt.id=aggView8141894429224473657.v4);
select MIN(v5) as v37,MIN(v38) as v38,MIN(v39) as v39 from aggJoin8300876809396456484;
