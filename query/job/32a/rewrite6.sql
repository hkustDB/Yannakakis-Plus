create or replace view aggView5733744956563458115 as select title as v26, id as v11 from title as t2;
create or replace view aggView3411695245128017783 as select id as v13, title as v14 from title as t1;
create or replace view aggJoin6496038162008132466 as (
with aggView6039257461868523284 as (select v13, MIN(v14) as v38 from aggView3411695245128017783 group by v13)
select movie_id as v13, linked_movie_id as v11, link_type_id as v4, v38 from movie_link as ml, aggView6039257461868523284 where ml.movie_id=aggView6039257461868523284.v13);
create or replace view aggJoin8159016973692747132 as (
with aggView3258256331504875570 as (select id as v4, link as v37 from link_type as lt)
select v13, v11, v38, v37 from aggJoin6496038162008132466 join aggView3258256331504875570 using(v4));
create or replace view aggJoin477564443563010150 as (
with aggView4819368153334624710 as (select id as v8 from keyword as k where keyword= '10,000-mile-club')
select movie_id as v13 from movie_keyword as mk, aggView4819368153334624710 where mk.keyword_id=aggView4819368153334624710.v8);
create or replace view aggJoin1877628069239269493 as (
with aggView7050163022844779752 as (select v13 from aggJoin477564443563010150 group by v13)
select v11, v38 as v38, v37 as v37 from aggJoin8159016973692747132 join aggView7050163022844779752 using(v13));
create or replace view aggJoin5925072076860686555 as (
with aggView6656321125951078409 as (select v11, MIN(v38) as v38, MIN(v37) as v37 from aggJoin1877628069239269493 group by v11,v38,v37)
select v26, v38, v37 from aggView5733744956563458115 join aggView6656321125951078409 using(v11));
select MIN(v37) as v37,MIN(v38) as v38,MIN(v26) as v39 from aggJoin5925072076860686555;
