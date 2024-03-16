create or replace view aggView1019160892347492629 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin5067070831615066973 as select id as v12, title as v13 from title as t, aggView1019160892347492629 where t.id=aggView1019160892347492629.v12 and production_year>2010;
create or replace view aggView5731825669306373502 as select v12, MIN(v13) as v24 from aggJoin5067070831615066973 group by v12;
create or replace view aggJoin1558266383922603099 as select keyword_id as v1, v24 from movie_keyword as mk, aggView5731825669306373502 where mk.movie_id=aggView5731825669306373502.v12;
create or replace view aggView578752858386784038 as select v1, MIN(v24) as v24 from aggJoin1558266383922603099 group by v1;
create or replace view aggJoin762055169969475365 as select v24 from keyword as k, aggView578752858386784038 where k.id=aggView578752858386784038.v1 and keyword LIKE '%sequel%';
select MIN(v24) as v24 from aggJoin762055169969475365;
