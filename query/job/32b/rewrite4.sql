create or replace view aggView1117199022267270543 as select id as v13, title as v14 from title as t1;
create or replace view aggView978110959913262468 as select id as v11, title as v26 from title as t2;
create or replace view aggJoin8388876466651753164 as (
with aggView2784917947278359222 as (select v13, MIN(v14) as v38 from aggView1117199022267270543 group by v13)
select movie_id as v13, linked_movie_id as v11, link_type_id as v4, v38 from movie_link as ml, aggView2784917947278359222 where ml.movie_id=aggView2784917947278359222.v13);
create or replace view aggJoin3994016558568880936 as (
with aggView8018214643633517313 as (select v11, MIN(v26) as v39 from aggView978110959913262468 group by v11)
select v13, v4, v38 as v38, v39 from aggJoin8388876466651753164 join aggView8018214643633517313 using(v11));
create or replace view aggJoin4973441724355139223 as (
with aggView3461982087261877560 as (select id as v8 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v13 from movie_keyword as mk, aggView3461982087261877560 where mk.keyword_id=aggView3461982087261877560.v8);
create or replace view aggJoin8414235369028270490 as (
with aggView8577149112755866873 as (select v13 from aggJoin4973441724355139223 group by v13)
select v4, v38 as v38, v39 as v39 from aggJoin3994016558568880936 join aggView8577149112755866873 using(v13));
create or replace view aggJoin312807611331020651 as (
with aggView5580288738928733 as (select v4, MIN(v38) as v38, MIN(v39) as v39 from aggJoin8414235369028270490 group by v4,v38,v39)
select link as v5, v38, v39 from link_type as lt, aggView5580288738928733 where lt.id=aggView5580288738928733.v4);
select MIN(v5) as v37,MIN(v38) as v38,MIN(v39) as v39 from aggJoin312807611331020651;
