create or replace view aggView1453276987349750947 as select id as v8, name as v9 from company_name as cn2;
create or replace view aggView3994639711103242210 as select id as v1, name as v2 from company_name as cn1 where country_code= '[us]';
create or replace view aggJoin697715714109423475 as (
with aggView8716032826944309396 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView8716032826944309396 where t1.kind_id=aggView8716032826944309396.v19);
create or replace view aggView8068950845120430295 as select v49, v50 from aggJoin697715714109423475 group by v49,v50;
create or replace view aggJoin3764760974403654989 as (
with aggView8666967878736575126 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView8666967878736575126 where t2.kind_id=aggView8666967878736575126.v21 and production_year<=2008 and production_year>=2005);
create or replace view aggView3809240923320224515 as select v61, v62 from aggJoin3764760974403654989 group by v61,v62;
create or replace view aggJoin3950062381492367237 as (
with aggView2814478882804744437 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView2814478882804744437 where mi_idx2.info_type_id=aggView2814478882804744437.v17 and info<'3.0');
create or replace view aggView2137226538672750736 as select v61, v43 from aggJoin3950062381492367237 group by v61,v43;
create or replace view aggJoin2096939695621034733 as (
with aggView6285196558036504417 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView6285196558036504417 where mi_idx1.info_type_id=aggView6285196558036504417.v15);
create or replace view aggView9220125561443435474 as select v49, v38 from aggJoin2096939695621034733 group by v49,v38;
create or replace view aggJoin7565708600843737251 as (
with aggView5354407214649484532 as (select v49, MIN(v38) as v75 from aggView9220125561443435474 group by v49)
select v49, v50, v75 from aggView8068950845120430295 join aggView5354407214649484532 using(v49));
create or replace view aggJoin7153078002378031457 as (
with aggView7577161518898254566 as (select v8, MIN(v9) as v74 from aggView1453276987349750947 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView7577161518898254566 where mc2.company_id=aggView7577161518898254566.v8);
create or replace view aggJoin3316881408919020218 as (
with aggView2787451310466773137 as (select v1, MIN(v2) as v73 from aggView3994639711103242210 group by v1)
select movie_id as v49, v73 from movie_companies as mc1, aggView2787451310466773137 where mc1.company_id=aggView2787451310466773137.v1);
create or replace view aggJoin2461861673766661961 as (
with aggView6156364341609678445 as (select v49, MIN(v75) as v75, MIN(v50) as v77 from aggJoin7565708600843737251 group by v49,v75)
select v49, v73 as v73, v75, v77 from aggJoin3316881408919020218 join aggView6156364341609678445 using(v49));
create or replace view aggJoin246555115792328113 as (
with aggView2625235203335636030 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select movie_id as v49, linked_movie_id as v61 from movie_link as ml, aggView2625235203335636030 where ml.link_type_id=aggView2625235203335636030.v23);
create or replace view aggJoin7202694763309037240 as (
with aggView419049904299760327 as (select v61, MIN(v74) as v74 from aggJoin7153078002378031457 group by v61,v74)
select v61, v43, v74 from aggView2137226538672750736 join aggView419049904299760327 using(v61));
create or replace view aggJoin1342267245340694228 as (
with aggView8394522115054363428 as (select v49, MIN(v73) as v73, MIN(v75) as v75, MIN(v77) as v77 from aggJoin2461861673766661961 group by v49,v75,v77,v73)
select v61, v73, v75, v77 from aggJoin246555115792328113 join aggView8394522115054363428 using(v49));
create or replace view aggJoin7957825401134204793 as (
with aggView484129361788040765 as (select v61, MIN(v73) as v73, MIN(v75) as v75, MIN(v77) as v77 from aggJoin1342267245340694228 group by v61,v75,v77,v73)
select v61, v43, v74 as v74, v73, v75, v77 from aggJoin7202694763309037240 join aggView484129361788040765 using(v61));
create or replace view aggJoin7165402625009545980 as (
with aggView4343043087024047753 as (select v61, MIN(v74) as v74, MIN(v73) as v73, MIN(v75) as v75, MIN(v77) as v77, MIN(v43) as v76 from aggJoin7957825401134204793 group by v61,v75,v77,v73,v74)
select v62, v74, v73, v75, v77, v76 from aggView3809240923320224515 join aggView4343043087024047753 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v62) as v78 from aggJoin7165402625009545980;
