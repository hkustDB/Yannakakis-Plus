create or replace view aggView5423694113261206399 as select id as v1, name as v2 from company_name as cn1 where country_code<> '[us]';
create or replace view aggView1104612312019760941 as select name as v9, id as v8 from company_name as cn2;
create or replace view aggJoin61462675374991389 as (
with aggView8249197249918587703 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView8249197249918587703 where mi_idx1.info_type_id=aggView8249197249918587703.v15);
create or replace view aggView4591504572835391465 as select v49, v38 from aggJoin61462675374991389 group by v49,v38;
create or replace view aggJoin3750827804432212698 as (
with aggView439355188518625915 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView439355188518625915 where t2.kind_id=aggView439355188518625915.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggView7984707943022388708 as select v62, v61 from aggJoin3750827804432212698 group by v62,v61;
create or replace view aggJoin4306207594970087741 as (
with aggView6304667542942821928 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView6304667542942821928 where t1.kind_id=aggView6304667542942821928.v19);
create or replace view aggView4198627830842839284 as select v50, v49 from aggJoin4306207594970087741 group by v50,v49;
create or replace view aggJoin1612608507529873672 as (
with aggView7098521064690964795 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView7098521064690964795 where mi_idx2.info_type_id=aggView7098521064690964795.v17);
create or replace view aggJoin6489248857567335861 as (
with aggView982533487747497248 as (select v61, v43 from aggJoin1612608507529873672 group by v61,v43)
select v61, v43 from aggView982533487747497248 where v43<'3.5');
create or replace view aggJoin155513180053823369 as (
with aggView3634552437034202149 as (select v1, MIN(v2) as v73 from aggView5423694113261206399 group by v1)
select movie_id as v49, v73 from movie_companies as mc1, aggView3634552437034202149 where mc1.company_id=aggView3634552437034202149.v1);
create or replace view aggJoin4361727242552146897 as (
with aggView7198080293431909684 as (select v61, MIN(v62) as v78 from aggView7984707943022388708 group by v61)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v78 from movie_link as ml, aggView7198080293431909684 where ml.linked_movie_id=aggView7198080293431909684.v61);
create or replace view aggJoin6255513321632233429 as (
with aggView5195745162554587295 as (select v49, MIN(v38) as v75 from aggView4591504572835391465 group by v49)
select v50, v49, v75 from aggView4198627830842839284 join aggView5195745162554587295 using(v49));
create or replace view aggJoin8445038373346903623 as (
with aggView1244042861472355610 as (select v49, MIN(v73) as v73 from aggJoin155513180053823369 group by v49)
select v50, v49, v75 as v75, v73 from aggJoin6255513321632233429 join aggView1244042861472355610 using(v49));
create or replace view aggJoin8808643111369879098 as (
with aggView3751549029709883443 as (select v49, MIN(v75) as v75, MIN(v73) as v73, MIN(v50) as v77 from aggJoin8445038373346903623 group by v49)
select v61, v23, v78 as v78, v75, v73, v77 from aggJoin4361727242552146897 join aggView3751549029709883443 using(v49));
create or replace view aggJoin2684665520113913042 as (
with aggView4861754435917497142 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v61, v78, v75, v73, v77 from aggJoin8808643111369879098 join aggView4861754435917497142 using(v23));
create or replace view aggJoin1481280540185744244 as (
with aggView8277519071722023414 as (select v61, MIN(v78) as v78, MIN(v75) as v75, MIN(v73) as v73, MIN(v77) as v77 from aggJoin2684665520113913042 group by v61)
select v61, v43, v78, v75, v73, v77 from aggJoin6489248857567335861 join aggView8277519071722023414 using(v61));
create or replace view aggJoin1721506692006654800 as (
with aggView3218227192625282933 as (select v61, MIN(v78) as v78, MIN(v75) as v75, MIN(v73) as v73, MIN(v77) as v77, MIN(v43) as v76 from aggJoin1481280540185744244 group by v61)
select company_id as v8, v78, v75, v73, v77, v76 from movie_companies as mc2, aggView3218227192625282933 where mc2.movie_id=aggView3218227192625282933.v61);
create or replace view aggJoin685725466178092207 as (
with aggView1372911404233864064 as (select v8, MIN(v78) as v78, MIN(v75) as v75, MIN(v73) as v73, MIN(v77) as v77, MIN(v76) as v76 from aggJoin1721506692006654800 group by v8)
select v9, v78, v75, v73, v77, v76 from aggView1104612312019760941 join aggView1372911404233864064 using(v8));
select MIN(v73) as v73,MIN(v9) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin685725466178092207;
