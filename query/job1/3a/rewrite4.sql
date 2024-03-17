create or replace view aggView1350110707657877244 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin5377684930438478866 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView1350110707657877244 where mk.movie_id=aggView1350110707657877244.v12;
create or replace view aggView5409890465601483484 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7960448901990207698 as select v12, v24 from aggJoin5377684930438478866 join aggView5409890465601483484 using(v1);
create or replace view aggView7530163469393174728 as select v12, MIN(v24) as v24 from aggJoin7960448901990207698 group by v12;
create or replace view aggJoin475480583515791840 as select info as v7, v24 from movie_info as mi, aggView7530163469393174728 where mi.movie_id=aggView7530163469393174728.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
select MIN(v24) as v24 from aggJoin475480583515791840;
