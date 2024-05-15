create or replace view aggView7689980387327289784 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6125881458503009360 as select movie_id as v12 from movie_keyword as mk, aggView7689980387327289784 where mk.keyword_id=aggView7689980387327289784.v1;
create or replace view aggView114703287739062597 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin6826930884612496219 as select v12 from aggJoin6125881458503009360 join aggView114703287739062597 using(v12);
create or replace view aggView5569634238088897274 as select v12 from aggJoin6826930884612496219 group by v12;
create or replace view aggJoin2043302344525986724 as select title as v13, production_year as v16 from title as t, aggView5569634238088897274 where t.id=aggView5569634238088897274.v12 and production_year>2005;
create or replace view aggView842235442142678338 as select v13 from aggJoin2043302344525986724;
select MIN(v13) as v24 from aggView842235442142678338;
