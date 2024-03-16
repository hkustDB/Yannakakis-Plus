create or replace view aggView3817235344601100056 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin7923084191664956592 as select movie_id as v12, keyword_id as v1 from movie_keyword as mk, aggView3817235344601100056 where mk.movie_id=aggView3817235344601100056.v12;
create or replace view aggView453677854867642235 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4713574396147018850 as select v12 from aggJoin7923084191664956592 join aggView453677854867642235 using(v1);
create or replace view aggView756788561557661762 as select v12 from aggJoin4713574396147018850 group by v12;
create or replace view aggJoin3448041381809379584 as select title as v13 from title as t, aggView756788561557661762 where t.id=aggView756788561557661762.v12 and production_year>2005;
create or replace view res as select MIN(v13) as v24 from aggJoin3448041381809379584;
select sum(v24) from res;