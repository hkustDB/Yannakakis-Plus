create or replace view aggView5446282649853115976 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8834663832050814564 as select movie_id as v12 from movie_keyword as mk, aggView5446282649853115976 where mk.keyword_id=aggView5446282649853115976.v1;
create or replace view aggView8176285592057605169 as select v12 from aggJoin8834663832050814564 group by v12;
create or replace view aggJoin1264109364051722371 as select id as v12, title as v13, production_year as v16 from title as t, aggView8176285592057605169 where t.id=aggView8176285592057605169.v12 and production_year>2010;
create or replace view aggView3434693678201985827 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin2903855837370960658 as select v13, v16 from aggJoin1264109364051722371 join aggView3434693678201985827 using(v12);
create or replace view aggView2914734869766170144 as select v13 from aggJoin2903855837370960658 group by v13;
select MIN(v13) as v24 from aggView2914734869766170144;
