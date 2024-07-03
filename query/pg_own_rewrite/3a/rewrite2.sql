create or replace view aggView3856545115925096630 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5240943630310027546 as select movie_id as v12 from movie_keyword as mk, aggView3856545115925096630 where mk.keyword_id=aggView3856545115925096630.v1;
create or replace view aggView1124225496477553418 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin8913806014031230184 as select id as v12, title as v13, production_year as v16 from title as t, aggView1124225496477553418 where t.id=aggView1124225496477553418.v12 and production_year>2005;
create or replace view aggView4673015151573186080 as select v12 from aggJoin5240943630310027546 group by v12;
create or replace view aggJoin8139193605326154022 as select v13, v16 from aggJoin8913806014031230184 join aggView4673015151573186080 using(v12);
create or replace view aggView224608336695795652 as select v13 from aggJoin8139193605326154022;
select MIN(v13) as v24 from aggView224608336695795652;
