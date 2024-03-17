create or replace view aggView8779929753575804460 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin449967957406362570 as select id as v12, title as v13 from title as t, aggView8779929753575804460 where t.id=aggView8779929753575804460.v12 and production_year>1990;
create or replace view aggView1682240036011910746 as select v12, MIN(v13) as v24 from aggJoin449967957406362570 group by v12;
create or replace view aggJoin8713979834563030817 as select keyword_id as v1, v24 from movie_keyword as mk, aggView1682240036011910746 where mk.movie_id=aggView1682240036011910746.v12;
create or replace view aggView2933655793428699354 as select v1, MIN(v24) as v24 from aggJoin8713979834563030817 group by v1;
create or replace view aggJoin3955969769614890903 as select v24 from keyword as k, aggView2933655793428699354 where k.id=aggView2933655793428699354.v1 and keyword LIKE '%sequel%';
create or replace view res as select MIN(v24) as v24 from aggJoin3955969769614890903;
select sum(v24) from res;