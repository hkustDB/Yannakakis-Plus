create or replace view aggView1347812274226026098 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8881699436649505026 as select movie_id as v15, note as v9 from movie_companies as mc, aggView1347812274226026098 where mc.company_type_id=aggView1347812274226026098.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView8974614481622155873 as select v15 from aggJoin8881699436649505026 group by v15;
create or replace view aggJoin2079940638644630114 as select id as v15, title as v16 from title as t, aggView8974614481622155873 where t.id=aggView8974614481622155873.v15 and production_year>2005;
create or replace view aggView4086206149899645263 as select v15, MIN(v16) as v27 from aggJoin2079940638644630114 group by v15;
create or replace view aggJoin264041599500596435 as select info_type_id as v3, v27 from movie_info as mi, aggView4086206149899645263 where mi.movie_id=aggView4086206149899645263.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView7370764711686693664 as select id as v3 from info_type as it;
create or replace view aggJoin7617124184794729118 as select v27 from aggJoin264041599500596435 join aggView7370764711686693664 using(v3);
select MIN(v27) as v27 from aggJoin7617124184794729118;
